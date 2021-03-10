module ApplicationHelper
    def display_notice_and_alert
        msg = ''
        msg << (content_tag :div, notice, :class => "notice") if notice
        msg << (content_tag :div, alert, :class => "alert") if alert
        sanitize msg
      end 



      require 'base64'


      require 'barby'
      require 'barby/barcode/code_128'
      require 'barby/barcode/qr_code'
      require 'barby/barcode/code_39'
      require 'barby/outputter/ascii_outputter'
      require 'barby/outputter/png_outputter'
  
      def generate_qr_code content
        data = Barby::QrCode.new(content)
        base64_output = Base64.encode64 data.to_png({ margin: 2, xdim: 26, ydim: 26 })
        "data:image/png;base64,#{base64_output}".gsub(/\n/, '')
      end
  
  
      def make_barcode(content) 
        data = Barby::Code128B.new(content)
        base64_output = Base64.encode64 data.to_png({ margin: 2, xdim: 3, ydim: 3 })
        "data:image/png;base64,#{base64_output}".gsub(/\n/, '')   
      end

end
