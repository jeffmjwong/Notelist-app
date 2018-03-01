require 'test/unit'

def add_gst(amount)
  amount + (amount*0.1) # => pass
end

def add_vat(amount)
  amount + (amount*0.1) # => fail
end

class OurTest < Test::Unit::TestCase
  def test_add_gst
    assert_equal(220, add_gst(200))
  end
  def test_add_vat
    assert_equal(115, add_vat(100))
  end
end
