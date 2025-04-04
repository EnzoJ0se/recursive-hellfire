local TextureEnum = {
	GRASS = "1G",
	GRASS_TILE = "1GT",
};

function TextureEnum.getAsset(texture)
	if texture == TextureEnum.GRASS then
		return "assets/textures/grass-1.png"
	end

	if texture == TextureEnum.GRASS_TILE then
		return "assets/textures/grass-tile.png"
	end
end

return TextureEnum;
