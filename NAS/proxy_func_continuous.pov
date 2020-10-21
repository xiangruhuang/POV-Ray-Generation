#include "colors.inc" 
                   

global_settings {
  ambient_light 0.3
}
           
camera {
  location <50, 50, -50>
  look_at <0, 0, 0>
}                  

light_source {
  <100, 100, -100>
  color White
}
        
#declare front_texture=
  texture{
    pigment{
      uv_mapping
      
      spiral2 8
      color_map {
        [0.5 color rgb <0.0,0,1> ]
        [0.5 color rgb 1 ]
      }
      scale 0.8
    }
    finish {
      specular 0.3
      roughness 0.01
    }
  }
#declare back_texture=
  texture{
    pigment{
      uv_mapping
      
      spiral2 8
      color_map {
        [0.5 color rgb <0.,0,1> ]
        [0.5 color rgb 1 ]
      }
      scale 0.8
    }
    finish {
      specular 0.3
      roughness 0.01
    }
  }
     


background { White }                    



#include "mesh.inc"