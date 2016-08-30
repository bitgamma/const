defmodule ConstTest do
  use ExUnit.Case
  doctest Const

  defmodule SimpleStatus do
    use Const, [:queued, :processed, :sent]
  end

  defmodule KeywordStatus do
    use Const, [queued: 10, processed: 20, sent: 30]
  end

  defmodule MixedStatus do
    use Const, [:queued, {:processed, 100}, :sent]
  end

  test "constants are generated" do
    assert SimpleStatus.queued == 0
    assert SimpleStatus.processed == 1
    assert SimpleStatus.sent == 2

    assert KeywordStatus.queued == 10
    assert KeywordStatus.processed == 20
    assert KeywordStatus.sent == 30

    assert MixedStatus.queued == 0
    assert MixedStatus.processed == 100
    assert MixedStatus.sent == 101
  end

  test "all function is generated" do
    assert SimpleStatus.all == [queued: 0, processed: 1, sent: 2]
    assert KeywordStatus.all == [queued: 10, processed: 20, sent: 30]
    assert MixedStatus.all == [queued: 0, processed: 100, sent: 101]
  end

  test "by_value function is generated" do
    assert SimpleStatus.by_value(0) == :queued
    assert SimpleStatus.by_value(1) == :processed
    assert SimpleStatus.by_value(2) == :sent

    assert KeywordStatus.by_value(10) == :queued
    assert KeywordStatus.by_value(20) == :processed
    assert KeywordStatus.by_value(30) == :sent

    assert MixedStatus.by_value(0) == :queued
    assert MixedStatus.by_value(100) == :processed
    assert MixedStatus.by_value(101) == :sent
  end
end
