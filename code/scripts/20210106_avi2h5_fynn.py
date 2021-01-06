import argparse
from dataclasses import dataclass
from pathlib import Path
from typing import Tuple

import av
import h5py
import numpy


@dataclass
class Meta:
    shape: Tuple[int, int, int, int]
    chunk_size: Tuple[int, int, int, int]
    dtype: numpy.dtype


def get_meta_data(avi_path: Path):
    assert avi_path.exists(), avi_path.absolute()

    container = av.open(str(avi_path))
    nr_frames: int = container.streams.video[0].frames
    img = next(container.decode(video=0)).to_image()  # PIL/Pillow image
    arr = numpy.asarray(img)
    frame_shape: Tuple[int, int, int] = arr.shape

    return Meta(shape=(nr_frames,) + frame_shape, chunk_size=(1,) + frame_shape, dtype=arr.dtype)


def avi2h5(avi_path: Path, h5_path: Path):
    assert avi_path.exists(), avi_path.absolute()
    assert not h5_path.exists(), h5_path.absolute()

    meta = get_meta_data(avi_path)
    print(meta)
    container = av.open(str(avi_path))

    try:
        with h5py.File(h5_path, "w") as h5_file:
            h5_dataset = h5_file.create_dataset("raw", shape=meta.shape, dtype=meta.dtype, chunks=meta.chunk_size)
            for i, frame in enumerate(container.decode(video=0)):
                img = frame.to_image()  # PIL/Pillow image
                arr = numpy.asarray(img)  # numpy array
                h5_dataset[i] = arr
                return

    except Exception:
        h5_path.unlink()


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("avi", type=Path)
    parser.add_argument("h5", type=Path)

    args = parser.parse_args()

    avi2h5(args.avi, args.h5)
