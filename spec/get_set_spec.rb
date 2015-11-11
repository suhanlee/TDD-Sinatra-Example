require File.expand_path '../spec_helper.rb', __FILE__

describe 'get_set_test' do
  it "should set value" do
    name = "test3"
    value = "1"

    get "/set/#{name}/#{value}"

    expect(last_response.body).to eq("{ #{name}: #{value} }")
  end

  it "should get value from name" do
    get "/set/test/1"
    get "/get/test"

    expect(last_response.body).to eq("{ test: 1 }")
  end
end