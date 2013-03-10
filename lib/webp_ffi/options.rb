module WebpFfi
  class Options
    
    def initialize(options)
      @user_options = options
    end
    
    def encode_pointer
      options_pointer = FFI::MemoryPointer.new :char, C::FfiWebpEncodeConfig.size, false
      options_struct = C::FfiWebpEncodeConfig.new options_pointer
      # default
      options_struct[:quality] = 100
      options_struct[:crop_x] = options_struct[:crop_y] = 0
      options_struct[:crop_w] = options_struct[:crop_h] = 0
      options_struct[:resize_w] = options_struct[:resize_h] = 0
      # users
      [:lossless, :quality, :method, :segments, :sns_strength, 
        :alpha_quality, :alpha_compression, :alpha_filtering, :width, :height,
        :crop_x, :crop_y, :crop_w, :crop_h, :resize_w, :resize_h].each do |key|
        options_struct[key] = @user_options[key] if @user_options[key]
      end
      options_pointer
    end
    
  end
end
