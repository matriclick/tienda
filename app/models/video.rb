class Video < ActiveRecord::Base
	belongs_to :videoable, :polymorphic => true
	
	before_save :check_url_code
	
	def check_url_code #DZF get the video code from youtube or vimeo urls, if this change, this method will not work
		if self.url_code.include? "http://www.youtube.com/" or self.url_code.include? "http://youtu.be/"
			code = self.url_code
			if code.include? "/watch?v="
				if code.include? "&"
					self.url_code = code[code.rindex('/watch?v=') + 9..code.index('&') - 1]
				else
					self.url_code = code[code.rindex('/watch?v=') + 9..code.length]
				end	
			else
				if code.include? "?"
					self.url_code = code[code.rindex('/') + 1..code.index('?') - 1]
				else
					self.url_code = code[code.rindex('/') + 1..code.length]
				end
			end
		elsif self.url_code.include? "vimeo.com"
			code = self.url_code
			self.url_code = code[code.index('vimeo.com') , code.length] 
		end
	end
end
