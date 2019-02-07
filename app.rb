require 'sinatra'
require 'sendgrid-ruby'
require "./cookie"
require "./muffin"
require "./cake"


get "/muffins" do
	@robot_zuckerberg = Muffin.new("Robot Zuckerberg", "This muffin is said to help the world's most advanced AI, Mark Zuckerberg, stay fueled up. Let it fuel you as well.", 4.45, "/Images/Robot-Zuckerberg.jpg")

	@big_brother = Muffin.new("Big Brother Banana Chip", "Have one and discuss the state of government and how much about us they really know.", 3.25, "/Images/Big-Brother-Chip.jpg")

	@doomsday_berry = Muffin.new("DoomsdayBerry", "This special blueberry muffin is eaten regularly by the wise folks with the doomsday signs on the side of the road. Better eat one before their premonitions come true and you lose your chance forever!", 2.75, "/Images/Doomsday-Berry.JPG")

	erb :muffins
end

get "/cookies" do
	@illuminati_biscotti = Cookie.new("Illuminati Biscotti", "A simple cookie that will help you to start seeing the discrepencies in society.", 2.99, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStK1QRghp3FXIVWYDrABwfUrLWJR60-Xcs7gkEaATqbG5t0_tE3g")

	@alien_abduction_cream = Cookie.new("Alien Abduction Cream", "An intergalactic treat that will jog your memory of the time you were probed in deep space.", 3.99, "/Images/Alien-Abduction-Cream.jpg")

	@moon_landing_chip = Cookie.new("Moon Landing Chip", "If you've ever wondered whether the moon landing was a hoax or not, then this delicacy is for you. One bite and you'll fly into sweet space and see things from another perspective.", 3.99, "/Images/Moon-Landing-Chip.jpg")

	erb :cookies
end

get "/cakes" do
	@bob_marley_brownie = Cake.new("Bob Marley Brownie", "Formerly the Bombastic Brownie, this is a Jamaican treat that will help you solve the world's mysteries like if you hit yourself and it hurts - are you strong or are you weak?", 4.25, "/Images/Bob-Marley-Brownies.jpg")

	@tupac_lives_cheesecake = Cake.new("Tupac Lives Cheesecake", "This cake is a favorite among a specific crowd that has the answers to where Tupac really is right now.", 3.75, "/Images/Tupac-Lives-Cheesecake.jpg")

	@juicy_fruit_kake = Cake.new("Juicy Fruit Kake", "Much like this suspiciously initialed cake, this fans of this fruity delight will have you wondering if JFK faked his death up until the last bite.", 3.25, "/Images/Juicy-Fruit-Kake.jpg")

	erb :cakes
end

get "/" do
erb :home
end

post "/" do
	@name = params[:name]
	@email = params[:email]

	from = SendGrid::Email.new(email: 'conspiracycuisine@cc.com')
	to = SendGrid::Email.new(email: @email)
	subject = 'Your catalogue, ' + @name
	content = SendGrid::Content.new(
		type: 'text/html',
		value: "<h1>Welcome to Conspiracy Cuisine!</h1>

		<span>Here's a list of our treats:</span>

		<ul><h3> ---Muffins---</h3><br \>
		<li>  Robot Zuckerberg <br \><br \>

		   	This muffin is said to help the world's most advanced AI, Mark Zuckerberg, stay fueled up. Let it fuel you as well.</li>
		<hr>

		<li> Big Brother Banana Chip <br \><br \>

		 		Have one and discuss the state of government and how much about us they really know. </li>
		<hr>

		<li> DoomsdayBerry <br \><br \>

		 		This special blueberry muffin is eaten regularly by the wise folks with the doomsday signs on the side of the road. Better eat one before their premonitions come true and you lose your chance forever!</li>
		</ul>
		<br \><br \>

		<ul><h3>---Cakes---</h3><br \>

		<li> Bob Marley Brownie<br \><br \>

			Formerly the Bombastic Brownie, this is a Jamaican treat that will help you solve the world's mysteries like if you hit yourself and it hurts - are you strong or are you weak?</li>
		<hr>

		<li> Tupac Lives Cheesecake<br \><br \>

				This cake is a favorite among a specific crowd that has the answers to where Tupac really is right now.</li>
		<hr>

		<li> Juicy Fruit Kake<br \><br \>

			Much like this suspiciously initialed cake, this fans of this fruity delight will have you wondering if JFK faked his death up until the last bite.</li>
		</ul>
		<br \><br \>

		<ul><h3>---Cookies---</h3><br \>

		<li> Illuminati Biscotti<br \><br \>

	 		A simple cookie that will help you to start seeing the discrepencies in society.</li>
		<hr>

		<li> Alien Abduction Cream<br \><br \>

			An intergalactic treat that will jog your memory of the time you were probed in deep space.</li>
		<hr>

		<li> Moon Landing Chip<br \><br \>

			If you've ever wondered whether the moon landing was a hoax or not, then this delicacy is for you. One bite and you'll fly into sweet space and see things from another perspective.</li>"

	)

	# create mail object with from, subject, to and content
	mail = SendGrid::Mail.new(from, subject, to, content)

	# sets up the api key
	sg = SendGrid::API.new(
	  api_key: ENV["SENDGRID_API_KEY"]
	)

	# sends the email
	response = sg.client.mail._('send').post(request_body: mail.to_json)

	# display http response code
	puts response.status_code

	# display http response headers
	puts response.headers

# redirect "/"
end

get "/about" do
	erb :about
end
