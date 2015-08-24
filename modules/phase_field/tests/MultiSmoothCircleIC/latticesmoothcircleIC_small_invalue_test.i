[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 25
  ny = 25
  xmax = 50
  ymax = 50
  elem_type = QUAD4
[]

[Variables]
  [./c]
    order = THIRD
    family = HERMITE
  [../]
[]

[ICs]
  [./c]
    type = SpecifiedSmoothCircleIC
    variable = c
    invalue = -0.8
    outvalue = 1
    int_width = 5
    x_positions = '25 32'
    z_positions = '0 0'
    y_positions = '25 32'
    radii = '6 5'
  [../]
[]

[Kernels]
  [./ie_c]
    type = TimeDerivative
    variable = c
  [../]
  [./CHSolid]
    type = CHMath
    variable = c
    mob_name = M
  [../]
  [./CHInterface]
    type = CHInterface
    variable = c
    kappa_name = kappa_c
    mob_name = M
  [../]
[]

[BCs]
  [./Periodic]
    [./all]
      auto_direction = 'x y'
    [../]
  [../]
[]

[Materials]
  [./constant]
    type = GenericConstantMaterial
    prop_names  = 'M kappa_c'
    prop_values = '1.0 1.5'
    block = 0
  [../]
[]

[Executioner]
  type = Transient
  scheme = bdf2

  solve_type = NEWTON
  petsc_options_iname = '-pc_type -pc_hypre_type -ksp_gmres_restart'
  petsc_options_value = 'hypre boomeramg 31'

  l_max_its = 20
  l_tol = 1.0e-5
  nl_max_its = 40
  nl_rel_tol = 5.0e-14

  start_time = 0.0
  num_steps = 1
  dt = 5
[]

[Outputs]
  exodus = true
  print_linear_residuals = true
  print_perf_log = true
[]
