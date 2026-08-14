#!/usr/bin/env python3
"""Pass a PNG through unchanged, except for pngpaste's invalid gAMA chunk."""

import struct
import sys


PNG_SIGNATURE = b"\x89PNG\r\n\x1a\n"
BAD_GAMMA = 219_998


def normalize(data: bytes) -> bytes:
    if not data.startswith(PNG_SIGNATURE):
        raise ValueError("input is not a PNG")

    output = bytearray(PNG_SIGNATURE)
    offset = len(PNG_SIGNATURE)
    while offset < len(data):
        if offset + 12 > len(data):
            raise ValueError("truncated PNG chunk")
        length = struct.unpack(">I", data[offset : offset + 4])[0]
        end = offset + 12 + length
        if end > len(data):
            raise ValueError("truncated PNG chunk data")

        chunk_type = data[offset + 4 : offset + 8]
        chunk_data = data[offset + 8 : offset + 8 + length]
        if not (chunk_type == b"gAMA" and length == 4 and struct.unpack(">I", chunk_data)[0] == BAD_GAMMA):
            output.extend(data[offset:end])
        offset = end

    return bytes(output)


if __name__ == "__main__":
    try:
        sys.stdout.buffer.write(normalize(sys.stdin.buffer.read()))
    except ValueError as error:
        print(f"normalize-png-gamma: {error}", file=sys.stderr)
        sys.exit(1)
