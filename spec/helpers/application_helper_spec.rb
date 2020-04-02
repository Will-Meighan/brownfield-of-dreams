require "spec_helper"

describe ApplicationHelper do
    it "returns true" do
      expect(helper.page_title).to eq(true)
    end
end
