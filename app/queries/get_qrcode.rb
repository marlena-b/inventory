# frozen_string_literal: true

class GetQRCode
  def initialize(product_url)
    @qrcode = RQRCode::QRCode.new(product_url)
  end

  # rubocop:disable Metrics/MethodLength
  def call
    @qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: 'black',
      file: nil,
      fill: 'white',
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 250
    )
  end
  # rubocop:enable Metrics/MethodLength
end
