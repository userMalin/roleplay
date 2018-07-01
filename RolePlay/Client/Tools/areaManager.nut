/*

	Script: area-manager.nut
	Side: Client

	Author: Patrix

*/

local _Config =
{
	DEBUG_MODE = false,

	DEBUG_MODEL_2D = "INVISIBLE_WAYPOINT.3DS",
	DEBUG_MODEL_3D = "INVISIBLE_ZCVOBMARKER.3DS",

	FRAME_RATE = 0.1,
	FRAME_COUNTER = 0.0
}

local function isInArea(area, x, z, condition)
{
	if ((type(x) == "integer" || type(x) == "float")
		&& (type(z) == "integer" || type(z) == "float")
		&& condition)
	{
		local j = area.polyX.len() - 1
		local isIn = false

		for (local i = 0; i < area.polyX.len(); j = i++)
		{
			if ( (area.polyZ[i] > z) != (area.polyZ[j] > z)
				&& (x < (area.polyX[j] - area.polyX[i]) * (z - area.polyZ[i]) / (area.polyZ[j] - area.polyZ[i]) + area.polyX[i]) )
			{
			   isIn = !isIn
			}
		}

		return isIn
	}
}

class baseArea
{
	static region = {}

	world = getWorld().toupper()

	polyX = []
	polyZ = []

	testY = null
	vobs = []

	isIn = false

	onEnter = null
	onExit = null

	constructor(arg = null)
	{
		if (_Config.DEBUG_MODE)
		{
			testY = 0
			vobs = []
		}
		else
		{
			vobs = null
		}

		polyX = []
		polyZ = []

		if (arg.rawin("world") && type(arg.world) == "string")
		{
			world = arg.world.toupper()
		}

		if (!(world in region))
		{
			region[world] <- {}
		}

		region[world][this] <- this
	}

	function remove()
	{
		if (_Config.DEBUG_MODE)
		{
			vobs.clear()
		}

		if (isIn && type(onExit) != null)
		{
			onExit()
		}

		if (region[world].len() <= 0)
		{
			delete region[world]
		}
		else
		{
			delete region[world][this]
		}
	}

	static function onRender(obj)
	{
		_Config.FRAME_COUNTER++

		if (_Config.FRAME_COUNTER / getFpsRate() >= _Config.FRAME_RATE)
		{
			_Config.FRAME_COUNTER = 0.0

			local world = getWorld().toupper()

			if (world in obj.region)
			{
				foreach (area in obj.region[world])
				{
					if ("renderCheck" in area)
					{
						area.renderCheck(area)
					}
				}
			}
		}
	}
}

addEventHandler("onRender",function()
{
		baseArea.onRender(baseArea)
})

class Area extends baseArea
{
	polyY = null
	pos = []

	constructor(arg)
	{
		pos = []

		if (type(arg) == "table")
		{
			base.constructor(arg)

			if (arg.rawin("y") && type(arg.y) == "table")
			{
				if (_Config.DEBUG_MODE)
				{
					vobs.push([])
					vobs.push([])
				}

				polyY = {}

				polyY.min <- arg.y.min
				polyY.max <- arg.y.max
			}

			if (arg.rawin("pos") && type(arg.pos) == "array")
			{
				local i = 0

				foreach(v in arg.pos)
				{
					polyX.push(v.x)
					polyZ.push(v.z)

					if (_Config.DEBUG_MODE)
					{
						if (!(type(polyY) == "table"))
						{
							vobs.push(Vob(_Config.DEBUG_MODEL_2D))

							vobs[i].setPosition(polyX[i], testY, polyZ[i])
						}
						else
						{
							vobs[0].push(Vob(_Config.DEBUG_MODEL_3D))
							vobs[1].push(Vob(_Config.DEBUG_MODEL_3D))

							vobs[0][i].setPosition(polyX[i], polyY.min, polyZ[i])
							vobs[1][i].setPosition(polyX[i], polyY.max, polyZ[i])
						}

						i++
					}
				}
			}
		}
	}

	static function renderCheck(area)
	{
		local pos = getPlayerPosition(heroId)

		local condition = true

		if (type(area.polyY) == "table")
		{
			condition = (pos.y >= area.polyY.min && pos.y <= area.polyY.max)
		}

		local isIn = isInArea(area, pos.x, pos.z, condition)

		if (isIn && !area.isIn)
		{
			area.isIn = true

			if (type(area.onEnter) == "function")
			{
				area.onEnter()
			}
		}
		else if (!isIn && area.isIn)
		{
			area.isIn = false

			if (type(area.onExit) == "function")
			{
				area.onExit()
			}
		}
	}
}

class Circle extends baseArea
{
	x = 0
	z = 0

	vertex = 16
	radius = 500

	polyY = null

	constructor(arg)
	{
		if (type(arg) == "table"
			&& (arg.rawin("x") && (type(arg.x) == "integer" || type(arg.x) == "float"))
			&& (arg.rawin("z") && (type(arg.z) == "integer" || type(arg.z) == "float")))
		{
			base.constructor(arg)

			x = arg.x
			z = arg.z

			if (arg.rawin("testY") && (type(arg.testY) == "integer" || type(arg.testY) == "float"))
			{
				testY = arg.testY
			}

			if (arg.rawin("y") && type(arg.y) == "table")
			{
				if (_Config.DEBUG_MODE)
				{
					vobs.push([])
					vobs.push([])
				}

				polyY = {}

				polyY.min <- arg.y.min
				polyY.max <- arg.y.max
			}

			if (arg.rawin("radius") && (type(arg.radius) == "integer" || type(arg.radius) == "float"))
			{
				radius = arg.radius
			}

			if (arg.rawin("vertex") && arg.vertex > 0)
			{
				vertex = arg.vertex
			}
		}

		local i = 0

		for (local angle = 0; angle < PI * 2; angle += PI / (vertex / 2))
		{
			polyX.push(x + (cos(angle) * radius))
			polyZ.push(z + (sin(angle) * radius))

			if (_Config.DEBUG_MODE)
			{
				if (!(type(polyY) == "table"))
				{
					vobs.push(Vob(_Config.DEBUG_MODEL_2D))

					vobs[i].setPosition(polyX[i], testY, polyZ[i])
				}
				else
				{
					vobs[0].push(Vob(_Config.DEBUG_MODEL_3D))
					vobs[1].push(Vob(_Config.DEBUG_MODEL_3D))

					vobs[0][i].setPosition(polyX[i], polyY.min, polyZ[i])
					vobs[1][i].setPosition(polyX[i], polyY.max, polyZ[i])
				}

				i++
			}
		}
	}

	static function renderCheck(area)
	{
		local pos = getPlayerPosition(heroId)

		if (getDistance2d(pos.x, pos.z, area.x, area.z) <= area.radius)
		{
			local condition = true

			if (type(area.polyY) == "table")
			{
				condition = (pos.y >= area.polyY.min && pos.y <= area.polyY.max)
			}

			local isIn = isInArea(area, pos.x, pos.z, condition)

			if (isIn && !area.isIn)
			{
				area.isIn = true

				if (type(area.onEnter) == "function")
				{
					area.onEnter()
				}
			}
			else if (!isIn && area.isIn)
			{
				area.isIn = false

				if (type(area.onExit) == "function")
				{
					area.onExit()
				}
			}
		}
		else if (area.isIn)
		{
			area.isIn = false

			if (type(area.onExit) == "function")
			{
				area.onExit()
			}
		}
	}

	function resize(radius)
	{
		if (type(radius) == "integer" || type(radius) == "float")
		{
			local i = 0

			for (local angle = 0; angle < PI * 2; angle += PI / (vertex / 2))
			{
				polyX[i] = x + (cos(angle) * radius)
				polyZ[i] = z + (sin(angle) * radius)

				if (_Config.DEBUG_MODE)
				{
					if (!(type(polyY) == "table"))
					{
						vobs[i].setPosition(polyX[i], testY, polyZ[i])
					}
					else
					{
						vobs[0][i].setPosition(polyX[i], polyY.min, polyZ[i])
						vobs[1][i].setPosition(polyX[i], polyY.max, polyZ[i])
					}
				}

				i++
			}

			this.radius = radius
		}
	}

	function setPosition(x,y,z)
	{
		if ((type(x) == "integer" || type(x) == "float")
			&& (type(z) == "integer" || type(z) == "float"))
		{
			local diffX = x - this.x
			local diffZ = z - this.z

			if (type(y) == "table"
				&& (type(y.min) == "integer" || type(y.min) == "float")
				&& (type(y.max) == "integer" || type(y.max) == "float"))
			{
				polyY.min = y.min
				polyY.max = y.max
			}

			for (local i = 0; i < vertex; i++)
			{
				polyX[i] = polyX[i] + diffX
				polyZ[i] = polyZ[i] + diffZ

				if (_Config.DEBUG_MODE)
				{
					if (!(type(polyY) == "table"))
					{
						vobs[i].setPosition(polyX[i], testY, polyZ[i])
					}
					else
					{
						vobs[0][i].setPosition(polyX[i], polyY.min, polyZ[i])
						vobs[1][i].setPosition(polyX[i], polyY.max, polyZ[i])
					}
				}
			}

			this.x = x
			this.z = z
		}
	}

	function setVertex(vertex)
	{
		if (type(vertex) == "integer" && vertex > 0)
		{
			polyX.clear()
			polyZ.clear()

			if (_Config.DEBUG_MODE)
			{
				if (!(type(polyY) == "table"))
				{
					vobs.clear()
				}
				else
				{
					vobs[0].clear()
					vobs[1].clear()
				}
			}

			local i = 0

			for (local angle = 0; angle < PI * 2; angle += PI / (vertex / 2))
			{
				polyX.push(x + (cos(angle) * radius))
				polyZ.push(z + (sin(angle) * radius))

				if (_Config.DEBUG_MODE)
				{
					if (!(type(polyY) == "array"))
					{
						vobs.push(Vob(_Config.DEBUG_MODEL_2D))

						vobs[i].setPosition(polyX[i], testY, polyZ[i])
					}
					else
					{
						vobs[0].push(Vob(_Config.DEBUG_MODEL_3D))
						vobs[1].push(Vob(_Config.DEBUG_MODEL_3D))

						vobs[0][i].setPosition(polyX[i], polyY.min, polyZ[i])
						vobs[1][i].setPosition(polyX[i], polyY.max, polyZ[i])
					}

					i++
				}
			}

			this.vertex = vertex
		}
	}
}
