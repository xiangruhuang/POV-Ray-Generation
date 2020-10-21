import argparse
from python.utils import PovRayGenerator
import scipy.io as sio
import numpy as np

PCKEYWORD = 'points3d'

def parse_args():
  parser = argparse.ArgumentParser(description=
      """
      This program generates a POV-Ray Script with camera, lighting source,
      and some object with colors.
      The input is given by a .mat file with the following attributes:
        'mesh_vertices': [n, 3] floats. (Conflict with pointcloud)
        'mesh_triangles': [m, 3] integers. (Conflict with pointcloud)
        'pointcloud': [n, 3] floats. (Conflict with mesh_vertices)
        'colors': [n, 3] floats. (Optional)
      """)
  parser.add_argument('--camera_loc', type=str,
    help='camera location, split by ","', default='50,50,50',
  )
  parser.add_argument('--look_at', type=str,
    help='origin location, split by ","', default='0,0,0',
  )
  parser.add_argument('--point_radius', type=str,
    help='radius of each point (drawn as a ball)', default='0.05',
  )
  parser.add_argument('--input', type=str,
    help='input .mat file', default=None
  )
  parser.add_argument('--output', type=str,
    help='output .pov file', default=None
  )
  args = parser.parse_args()
  args.camera_loc = np.array([float(token)
    for token in args.camera_loc.strip().split(',')]
  )
  args.look_at = np.array([float(token)
    for token in args.look_at.strip().split(',')]
  )
  return args

if __name__ == '__main__':
  args = parse_args()
  generator = PovRayGenerator()
  generator.radius = args.point_radius
  mat = sio.loadmat(args.input)
  if mat.get(PCKEYWORD, None) is not None:
    pointcloud = mat[PCKEYWORD]
    colors = mat.get('colors', None)
    with open(args.output, 'w') as fout:
      generator.generate_pov_ray_file(pointcloud, fout, colors)
