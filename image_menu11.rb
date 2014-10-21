require "./image_array.rb"

puts "File name? I already put an image called 'toucan.png' in this directory, or you can upload your own. Note: only png images work"
file_name = gets.chomp
	# check if file exists
	if !File.exists?("./#{file_name}")
		puts "**EITHER THE FILE YOU ARE TRYING TO MANIPULATE DOES NOT EXIST OR HAS NOT BEEN COPIED TO THIS DIRECTORY**"
	else
		puts "Great!"
end
# create an image file
img = ImageArray.new(file_name)
# create an array to store all of the effects used to create a descriptive file name
used_effects = []

# open an image array at the given file path
while true
	 puts "Effect? Options: BW for black and white, INV for inverse, TINT for tint, RAND for random noise, MAX for maximizing a color, SUR for surprise colors, Q to quit, and DONE once you are finished applying effects." + ("\n") 
        effect = gets.downcase.chomp	

        if effect == "bw"
		used_effects.push "bw"
                # code to make the image array black and white
		img.each do |row|
        	row.each do |pixel|
                pixel_gray =(pixel.red + pixel.blue + pixel.green)/3
                pixel.red = pixel_gray
                pixel.green = pixel_gray
                pixel.blue = pixel_gray
        end
end
        elsif effect == "inv"
		used_effects.push "inv"
                # code to make the image array inverted colori
		img.each do |row|
			row.each do |pixel|
			pixel.red = img.max_intensity - pixel.red
			pixel.green = img.max_intensity - pixel.green
			pixel.blue = img.max_intensity - pixel.blue
		end
end
       elsif effect == "rand"
		used_effects.push "rand"
                # code to random noise the image
		img.each do |row|
			row.each do |pixel|
			pixel.green = rand(pixel.green)
			pixel.blue = rand(pixel.blue)
			pixel.red = rand(pixel.red)
	end
end
	elsif effect == "tint"
		used_effects.push "tint"
		# code to tint the image
		puts "Which tint color would you like? The options are red, yellow, green, turquoise, blue, and purple." ; tintcolor = gets.chomp.downcase
			img.each do |row|
				row.each do |pixel|
			pixel_gray = (pixel.red + pixel.green + pixel.blue)/3
				
				if tintcolor == "green"
					pixel.green = pixel_gray
					pixel.blue = 10
					pixel.red = 10
						end

				if tintcolor == "turquoise"
					pixel.green = pixel_gray
					pixel.blue = pixel_gray
					pixel.red = 10
						end

				if tintcolor == "purple"
					pixel.green = 10
					pixel.blue= pixel_gray
					pixel.red = pixel_gray
						end

				if tintcolor == "red"
					pixel.green = 10
					pixel.blue = 10
					pixel.red = pixel_gray
						end

				if tintcolor == "blue"
					pixel.green = 10
					pixel.blue = pixel_gray
					pixel.red = 10
						end
					
				if tintcolor == "yellow"
					pixel.green = pixel_gray
					pixel.blue = 10
					pixel.red = pixel_gray
						end
	end
end
		used_effects.push tintcolor

	elsif effect == "sur"
		used_effects.push "sur"
		# code to change the background color
		puts "Would you like blue, green, or red?" ; backcolor = gets.chomp.downcase
		if backcolor == "blue"
		img.each do |row|
			row.each do |pixel|
			pixel_gray = (pixel.red + pixel.blue + pixel.green)/3
			pixel.blue = pixel_gray 
                        pixel.green = pixel_gray + (pixel.green*0.1)
                        pixel.red = pixel_gray + (pixel.red*0.1)
		end
	end
end
		if backcolor == "green"
		img.each do |row|
			row.each do |pixel|
			pixel_gray = (pixel.red + pixel.blue + pixel.green)/3
                        pixel.green = pixel_gray 
                        pixel.blue = pixel_gray + (pixel.blue*0.1)
                        pixel.red = pixel_gray + (pixel.red*0.1)
		end
	end
end
		if backcolor == "red"
		img.each do |row|
			img.each do |pixel|
			pixel_gray = (pixel.red + pixel.blue + pixel.green)/3
                        pixel.red = pixel_gray
                        pixel.green = pixel_gray + (pixel.green*0.1)
                        pixel.blue = pixel_gray + (pixel.blue*0.1)
		end
	end
end
			used_effects.push "#{backcolor}"


	elsif effect == "max"
		used_effects.push "max"
		# code to make the image a color
		puts "Do you want to maximize the red, green, or blue?"
		color = gets.chomp.downcase
			if color == "red"
			img.each do |row|
				row.each do |pixel|
				pixel_gray = (pixel.red + pixel.blue + pixel.green)/3
				pixel.red = img.max_intensity
				pixel.green = pixel_gray
				pixel.blue = pixel_gray
				end
			end
		end
			if color == "green"
			img.each do |row|
				row.each do |pixel|
				pixel_gray = (pixel.red + pixel.blue + pixel.green)/3
				pixel.red = pixel_gray
				pixel.blue = pixel_gray
				pixel.green = img.max_intensity
				end
			end
		end
			if color == "blue"
			  img.each do |row|
                                row.each do |pixel|
				pixel_gray = (pixel.red + pixel.blue + pixel.green)/3
                                pixel.red = pixel_gray
                                pixel.green = pixel_gray
                                pixel.blue = img.max_intensity
				end
			end
		end
			used_effects.push "#{color}"

	elsif effect == "q" 
		puts "Thank you for using this program."
		break
	elsif effect == "done"
		img.write(file_name.sub(".png", "-#{effect}.png"))
		# join the elements of the array of effects by - to create a file name
		used_effects.pop
		joinedarray = used_effects.join("-")
		# create a descriptive file name for the new version of the manipulated image
		imagename = (file_name.sub(".png", "-#{joinedarray}.png"))
		# write the image 
		img.write imagename 
		puts "Your file has been written as a new file called #{imagename}. Now all you need to do is copy that image to your public html in order to view it!"
		break
	else 
		puts "That is not a valid effect. Try again or type 'q' to quit."
	end
end
