require 'net-https-wrapper'

describe 'Net::HTTP' do
  describe '.__post_or_put__' do
    it 'wraps posting using .new, #post and #body' do
      nh = mock('nh')
      Net::HTTP.should_receive(:new).with('aaa.bbb', 80).and_return(nh)
      def nh.use_ssl=(a); end
      def nh.verify_mode=(a); end
      def nh.post(a, b, c); 'ok' end
      Net::HTTP.__post_or_put__(
        :post,
        'http://aaa.bbb/ccc/ddd',
        'data',
        {'a' => 'b'}).should == 'ok'
    end
  end

  describe '.post, .put' do
    it 'wrap __post_or_put__' do
      Net::HTTP.should_receive(:__post_or_put__).with(:post, nil, nil, nil)
      Net::HTTP.post(nil, nil, nil)

      Net::HTTP.should_receive(:__post_or_put__).with(:put, nil, nil, nil)
      Net::HTTP.put(nil, nil, nil)
    end
  end
end


