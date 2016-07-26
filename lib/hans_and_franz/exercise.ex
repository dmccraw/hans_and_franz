defmodule HansAndFranz.Exercise do
  defstruct exercise: "", count: 0, description: ""

  @range_start 10
  @range_end   20

  def random do
    Enum.random(
      [
        %HansAndFranz.Exercise{
          exercise: :pushups,
          count: Enum.random(Range.new(@range_start, @range_end)),
          description: "pushups"
        },
        %HansAndFranz.Exercise{
          exercise: :jumping_jacks,
          count: Enum.random(Range.new(@range_start, @range_end)),
          description: "jumping jacks"
        },
        %HansAndFranz.Exercise{
          exercise: :lunges,
          count: Enum.random(Range.new(@range_start, @range_end)),
          description: "forward step lunges"
        },
        %HansAndFranz.Exercise{
          exercise: :crunches,
          count: Enum.random(Range.new(@range_start, @range_end)),
          description: "crunches"
        }
      ]
    )
  end
end
