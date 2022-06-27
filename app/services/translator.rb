require_relative '../services/base'

class Translator < Base
  SolidWorks = {
    global_preparing: "Dim swApp As Object
                       Dim Part As Object
                       Dim boolstatus As Boolean
                       Dim longstatus As Long, longwarnings As Long",
    main_initialize: "Sub main()",
    inner_preparing: "Set swApp = Application.SldWorks
                      Set Part = swApp.ActiveDoc
                      Dim myModelView As Object
                      Set myModelView = Part.ActiveView
                      myModelView.FrameState = swWindowState_e.swWindowMaximized",
    create_sketch: "Part.SketchManager.InsertSketch True
                    boolstatus = Part.Extension.SelectByID2(\"Спереди\", \"PLANE\", -5.74081580171783E-02, 3.42950945899541E-02, 0, False, 0, Nothing, 0)
                    Part.ClearSelection2 True",
    create_circle: "Part.SketchManager.CreateCircle(%{pointX}, %{pointY}, %{pointZ}, %{radius}, 0, 0)
                    Part.ClearSelection2 True",
    create_rectangle: "Part.SketchManager.CreateCornerRectangle(:pointX, %s, %s, %s, %s, %s)
                       Part.ClearSelection2 True",
    extrusion: "Part.FeatureManager.FeatureExtrusion2(True, False, False, 0, 0, 0.1, 0.01, False, False, False, False, 1.74532925199433E-02, 1.74532925199433E-02, False, False, False, False, True, True, True, 0, 0, False)
                Part.SelectionManager.EnableContourSelection = False",
    end_main_func: "Part.SelectionManager.EnableContourSelection = False
                    End Sub"
  }

  PARAMS = []

  CATIA = {
    global_preparing: "Language=\"VBSCRIPT\"",
    main_initialize: "Sub CATMain()",
    inner_preparing: "Set partDocument1 = CATIA.ActiveDocument
                    Set part1 = partDocument1.Part
                    Set bodies1 = part1.Bodies
                    Set body1 = bodies1.Item(\"Тело детали\")",
    create_sketch: "Set sketches1 = body1.Sketches
                  Set originElements1 = part1.OriginElements
                  Set reference1 = originElements1.PlaneYZ
                  Set sketch1 = sketches1.Add(reference1)
                  Dim arrayOfVariantOfDouble1(8)
                  arrayOfVariantOfDouble1(0) = 0.000000
                  arrayOfVariantOfDouble1(1) = 0.000000
                  arrayOfVariantOfDouble1(2) = 0.000000
                  arrayOfVariantOfDouble1(3) = 0.000000
                  arrayOfVariantOfDouble1(4) = 1.000000
                  arrayOfVariantOfDouble1(5) = 0.000000
                  arrayOfVariantOfDouble1(6) = 0.000000
                  arrayOfVariantOfDouble1(7) = 0.000000
                  arrayOfVariantOfDouble1(8) = 1.000000
                  sketch1.SetAbsoluteAxisData arrayOfVariantOfDouble1

                  part1.InWorkObject = sketch1
                  Set factory2D1 = sketch1.OpenEdition()
                  Set geometricElements1 = sketch1.GeometricElements
                  Set axis2D1 = geometricElements1.Item(\"AbsoluteAxis\")
                  Set line2D1 = axis2D1.GetItem(\"HDirection\")
                  Set line2D2 = axis2D1.GetItem(\"VDirection\")",
    create_circle: "Dim circle2D1 As Circle2D
                  Set circle2D1 = factory2D1.CreateClosedCircle(%{pointX}, %{pointY}, %{radius})
                  Dim point2D1 As AnyObject
                  Set point2D1 = axis2D1.GetItem(\"Origin\")
                  circle2D1.CenterPoint = point2D1",
    create_rectangle: "Set point2D1 = factory2D1.CreatePoint(100.778664, 0.000000)
                      Set line2D3 = factory2D1.CreateLine(0.000000, 0.000000, 100.778664, 0.000000)
                      line2D3.StartPoint = point2D2
                      line2D3.EndPoint = point2D1
                      Set point2D3 = factory2D1.CreatePoint(100.778664, 54.063534)

                      Set line2D4 = factory2D1.CreateLine(100.778664, 0.000000, 100.778664, 54.063534)
                      line2D4.StartPoint = point2D1
                      line2D4.EndPoint = point2D3
                      Set point2D4 = factory2D1.CreatePoint(0.000000, 54.063534)

                      Set line2D5 = factory2D1.CreateLine(100.778664, 54.063534, 0.000000, 54.063534)
                      line2D5.StartPoint = point2D3
                      line2D5.EndPoint = point2D4

                      Set line2D6 = factory2D1.CreateLine(0.000000, 54.063534, 0.000000, 0.000000)
                      line2D6.StartPoint = point2D4
                      line2D6.EndPoint = point2D2

                      Set constraints1 = sketch1.Constraints
                      Set reference2 = part1.CreateReferenceFromObject(line2D3)
                      Set reference3 = part1.CreateReferenceFromObject(line2D1)
                      Set constraint1 = constraints1.AddBiEltCst(catCstTypeHorizontality, reference2, reference3)
                      constraint1.Mode = catCstModeDrivingDimension
                      Set reference4 = part1.CreateReferenceFromObject(line2D5
                      Set reference5 = part1.CreateReferenceFromObject(line2D1)
                      Set constraint2 = constraints1.AddBiEltCst(catCstTypeHorizontality, reference4, reference5)
                      constraint2.Mode = catCstModeDrivingDimension
                      Set reference6 = part1.CreateReferenceFromObject(line2D4)
                      Set reference7 = part1.CreateReferenceFromObject(line2D2)
                      Set constraint3 = constraints1.AddBiEltCst(catCstTypeVerticality, reference6, reference7)
                      constraint3.Mode = catCstModeDrivingDimension
                      Set reference8 = part1.CreateReferenceFromObject(line2D6)
                      Set reference9 = part1.CreateReferenceFromObject(line2D2)
                      Set constraint4 = constraints1.AddBiEltCst(catCstTypeVerticality, reference8, reference9)
                      constraint4.Mode = catCstModeDrivingDimension
                      sketch1.CloseEdition",
    extrusion: "sketch1.CloseEdition
              part1.InWorkObject = sketch1
              part1.Update
              Set shapeFactory1 = part1.ShapeFactory
              Set pad1 = shapeFactory1.AddNewPad(sketch1, 20.000000)
              part1.Update ",
    end_main_func: "End Sub"
  }

  attr_accessor :input_text, :from, :to, :logic_tree

  def initialize(input_text:, from:, to:)
    @input_text = input_text
    @from = from
    @to = to
    @logic_tree = []
  end

  def call
    # p SolidWorks[:create_circle][:text] % {width: 10}
    create_logic_tree
    # logic_tree
    logic_tree_to_macros(logic_tree: logic_tree)
  end

  private

  def find_hash_to_compare(name:)
    case name
    when 'SolidWorks'
      SolidWorks
    when 'CATIA'
      CATIA
    end
  end

  def create_logic_tree
    hash_to_compare = find_hash_to_compare(name: from)
    # split("\r\n").each
    input_text.each_line do |row|
      hash_to_compare.each do |key, value|
        if slice_string(string: row.strip) == slice_string(string: value.split("\n").first)
          # array_params = select_params(string: row)
          logic_tree << { action: key,
                          params: select_params(string: row) }
        end
      end
    end
  end

  def logic_tree_to_macros (logic_tree:)
    result = ""
    hash_to_compare = find_hash_to_compare(name: to)

    logic_tree.each do |item|
      hash_to_compare.each do |key, value|
        result.concat(value % set_params(key, item[:params])) if item[:action] == key
      end

      result.concat "\r\n"
    end

    result
  end

  def slice_string(string:)
    string.slice!(0..(string.index('(') || 0) - 1)
  end

  def select_params(string:)
    string.slice!((string.index('(') || 0)..(string.index(')') || 0)).gsub(/[()]/, '').split(',')
  end

  def set_params (key, array)
    if (key == :create_circle)
      if from == 'SolidWorks' && to == 'CATIA'
        return { pointX: array[0], pointY: array[1], pointZ: array[2], radius: array[0].to_f + array[3].to_f }
      end
      if from == 'CATIA' && to == 'SolidWorks'
        return { pointX: array[0], pointY: array[1], pointZ: array[2], radius: array[0].to_f + array[3].to_f }
      end
    end
  end
end

# p Translator.call(input_text: "Set swApp = Application.SldWorks
# Set Part = swApp.ActiveDoc
# Dim myModelView As Object
# Set myModelView = Part.ActiveView
# myModelView.FrameState = swWindowState_e.swWindowMaximized
# Part.SketchManager.CreateCircle(0, 0, 0, 0.11567849387306, 5.40895787156994E-02, 0)",
#                   from: 'SolidWorks',
#                   to: 'CATIA')
# "Part.SketchManager.CreateCornerRectangle(0, 0, 0, 0.11567849387306, 5.40895787156994E-02, 0)"
#
# Sub main()
# Set swApp = Application.SldWorks
# Set Part = swApp.ActiveDoc
# Dim myModelView As Object
# Set myModelView = Part.ActiveView
# myModelView.FrameState = swWindowState_e.swWindowMaximized