defmodule AdventOfCode.Day16 do
  def field(<<0::1, field::4, rest::bits>>, fields) do
    {fields <> <<field>>, rest}
  end

  def field(<<1::1, field::4, rest::bits>>, fields) do
    field(rest, fields <> <<field>>)
  end

  def subpackets_by_length(bits, packets, count) do
    case parse(bits) do
      {:invalid, rest} ->
        IO.inspect(rest)
        packets

      {packet, rest} ->
        subpackets_by_length(rest, [packet | packets], count + 1)
    end
  end

  def subpackets_by_count(_bits, packets, 0), do: packets

  def subpackets_by_count(<<packet::11, rest::bits>>, packets, count) do
    {packet, _rest} = parse(packet)
    subpackets_by_count(rest, [packet | packets], count - 1)
  end

  def parse(<<version::3, 4::3, fields::bits>>) do
    {fields, rest} = field(fields, <<>>)

    {%{
       version: version,
       type: 4,
       fields: fields
     }, rest}
  end

  def parse(<<version::3, type::3, 0::1, length::15, rest::bits>>) do
    %{
      version: version,
      type: type,
      length: length,
      packets: subpackets_by_length(rest, [], 0)
    }
  end

  def parse(<<version::3, type::3, 1::1, count::unsigned-little-integer-size(15), rest::bits>>) do
    %{
      version: version,
      type: type,
      count: count,
      packets: subpackets_by_count(rest, [], 0)
    }
  end

  def parse(x) do
    {:invalid, x}
  end

  def part1(args) do
    args
    |> Base.decode16!()
  end

  def part2(args) do
  end
end
