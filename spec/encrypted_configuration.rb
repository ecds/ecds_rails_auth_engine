RSpec.shared_context 'encrypted configuration' do
  def stub_credential(key, value)
    allow(Rails.application).to receive(:credentials).and_return(OpenStruct.new(key.to_sym => value))
  end
end