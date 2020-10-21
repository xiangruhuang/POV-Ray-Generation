import numpy as np
import open3d as o3d

class PovRayGenerator():
  def __init__(self, view_point = [0, 0, -1], scale=50):
    self.scale = 2
    self.view_point = np.array(view_point) * self.scale
    self.origin = np.zeros(3) * self.scale
    self.color = np.array([0,0,1]) # blue
    self.radius = 0.9
    self.lightsource = np.array([2, 2, -2]) * self.scale

  def generate_pov_ray_file(self, pointcloud, fout, colors=None):
    if colors is None:
      colors = np.stack([self.color for i in range(pointcloud.shape[0])], 0)
    self.print_header(fout)
    self.print_camera_and_lighting(fout)
    self.print_background(fout)
    center = np.mean(pointcloud, 0)
    print(center)
    pointcloud = pointcloud - center + self.origin
    fout.write('union {\n')
    for i in range(pointcloud.shape[0]):
      fout.write('  sphere {\n')
      fout.write('    <{}, {}, {}>, {}\n'.format(
        pointcloud[i, 0],
        pointcloud[i, 1],
        pointcloud[i, 2],
        self.radius
        )
      )
      fout.write('    texture {{ pigment {{ rgb<{}, {}, {}> }} }}\n'.format(
        colors[i, 0], colors[i, 1], colors[i, 2]
        )
      )
      fout.write('  }\n')
    fout.write('}\n')

  def print_camera_and_lighting(self, fout):
    fout.write('camera {\n')
    fout.write('  location <{}, {}, {}>\n'.format(
      self.view_point[0],
      self.view_point[1],
      self.view_point[2])
    )
    fout.write('  look_at <{}, {}, {}>\n'.format(
      self.origin[0],
      self.origin[1],
      self.origin[2])
    )
    fout.write('}\n\n')
    fout.write('light_source {\n')
    fout.write('  <{}, {}, {}>\n'.format(
      self.lightsource[0], self.lightsource[1], self.lightsource[2],
      )
    )
    fout.write('  color White\n')
    fout.write('}\n\n')

  def print_header(self, fout):
    fout.write('#include "colors.inc"\n')
    fout.write('\n')
    fout.write('global_settings {\n')
    fout.write('  ambient_light 0.3\n')
    fout.write('}\n')
    fout.write('\n')

  def print_background(self, fout):
    fout.write('background { White }\n')

if __name__ == '__main__':
  generator = PovRayGenerator()
  pointcloud = np.random.randn(10, 3)
  with open('test.pov', 'w') as fout:
    generator.generate_pov_ray_file(pointcloud, fout)

