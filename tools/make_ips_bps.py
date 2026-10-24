#!/usr/bin/env python3
"""
Usage: python3 tools/make_ips_bps.py original.gbc modified.gbc out_basename

Write out_basename.ips and out_basename.bps, patches that turn
original.gbc into modified.gbc, and check that both apply correctly.
"""

import sys
import zlib


def diff_runs(src, dst, merge_gap):
	"""Yield (start, end) ranges where dst differs from src.
	Ranges separated by fewer than merge_gap equal bytes are merged."""
	start = end = None
	for i, (a, b) in enumerate(zip(src, dst)):
		if a != b:
			if start is None:
				start = i
			elif i - end >= merge_gap:
				yield start, end
				start = i
			end = i + 1
	if start is not None:
		yield start, end


def make_ips(src, dst):
	assert len(src) == len(dst) <= 0x1000000
	out = bytearray(b'PATCH')
	for start, end in diff_runs(src, dst, merge_gap=6):
		while start < end:
			size = min(end - start, 0xffff)
			assert start != 0x454f46, 'offset would read as "EOF"'
			out += start.to_bytes(3, 'big') + size.to_bytes(2, 'big') + dst[start:start + size]
			start += size
	out += b'EOF'
	return bytes(out)


def apply_ips(src, patch):
	assert patch[:5] == b'PATCH'
	out = bytearray(src)
	i = 5
	while patch[i:i + 3] != b'EOF':
		offset = int.from_bytes(patch[i:i + 3], 'big')
		size = int.from_bytes(patch[i + 3:i + 5], 'big')
		i += 5
		if size:
			out[offset:offset + size] = patch[i:i + size]
			i += size
		else:
			size = int.from_bytes(patch[i:i + 2], 'big')
			out[offset:offset + size] = patch[i + 2:i + 3] * size
			i += 3
	return bytes(out)


def bps_number(n):
	out = bytearray()
	while True:
		x = n & 0x7f
		n >>= 7
		if not n:
			out.append(0x80 | x)
			return out
		out.append(x)
		n -= 1


def make_bps(src, dst):
	assert len(src) == len(dst)
	out = bytearray(b'BPS1')
	out += bps_number(len(src)) + bps_number(len(dst)) + bps_number(0)
	pos = 0
	for start, end in diff_runs(src, dst, merge_gap=4):
		if start > pos:
			out += bps_number((start - pos - 1) << 2 | 0)  # SourceRead
		out += bps_number((end - start - 1) << 2 | 1)  # TargetRead
		out += dst[start:end]
		pos = end
	if pos < len(dst):
		out += bps_number((len(dst) - pos - 1) << 2 | 0)
	out += zlib.crc32(src).to_bytes(4, 'little')
	out += zlib.crc32(dst).to_bytes(4, 'little')
	out += zlib.crc32(out).to_bytes(4, 'little')
	return bytes(out)


def apply_bps(src, patch):
	def number():
		nonlocal i
		n, shift = 0, 1
		while True:
			x = patch[i]
			i += 1
			n += (x & 0x7f) * shift
			if x & 0x80:
				return n
			shift <<= 7
			n += shift

	assert patch[:4] == b'BPS1'
	assert zlib.crc32(patch[:-4]) == int.from_bytes(patch[-4:], 'little'), 'bad patch checksum'
	assert zlib.crc32(src) == int.from_bytes(patch[-12:-8], 'little'), 'wrong source ROM'
	i = 4
	src_size, dst_size, meta_size = number(), number(), number()
	assert src_size == len(src)
	i += meta_size
	out = bytearray()
	while i < len(patch) - 12:
		data = number()
		action, length = data & 3, (data >> 2) + 1
		if action == 0:
			out += src[len(out):len(out) + length]
		elif action == 1:
			out += patch[i:i + length]
			i += length
		else:
			raise ValueError('unsupported BPS action')
	assert len(out) == dst_size
	assert zlib.crc32(out) == int.from_bytes(patch[-8:-4], 'little'), 'bad output checksum'
	return bytes(out)


def main():
	if len(sys.argv) != 4:
		sys.exit(__doc__.strip())
	_, src_name, dst_name, out_name = sys.argv
	with open(src_name, 'rb') as f:
		src = f.read()
	with open(dst_name, 'rb') as f:
		dst = f.read()

	ips = make_ips(src, dst)
	bps = make_bps(src, dst)
	assert apply_ips(src, ips) == dst
	assert apply_bps(src, bps) == dst

	for ext, patch in (('ips', ips), ('bps', bps)):
		with open(f'{out_name}.{ext}', 'wb') as f:
			f.write(patch)
		print(f'{out_name}.{ext}: {len(patch)} bytes')


if __name__ == '__main__':
	main()
