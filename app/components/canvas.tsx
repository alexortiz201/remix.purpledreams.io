import { useEffect, useRef } from 'react'

type DotsType = {
	nb: number
	array: Dot[]
}

class Dot {
	x: number
	y: number
	vx: number
	vy: number
	radius: number
	canvas: HTMLCanvasElement
	ctx: CanvasRenderingContext2D
	dots: DotsType

	constructor(
		canvas: HTMLCanvasElement,
		ctx: CanvasRenderingContext2D,
		dots: DotsType,
	) {
		this.x = Math.random() * canvas.width
		this.y = Math.random() * canvas.height
		this.vx = -0.5 + Math.random()
		this.vy = -0.5 + Math.random()
		this.radius = Math.random()

		this.canvas = canvas
		this.ctx = ctx
		this.dots = dots
	}

	create() {
		this.ctx.beginPath()
		this.ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, false)
		this.ctx.fill()
	}

	animate() {
		for (let i = 0; i < this.dots.nb; i++) {
			let dot = this.dots.array[i]

			if (!dot) return

			if (dot.y < 0 || dot.y > this.canvas.height) [dot.vx, dot.vy] = [dot.vx, -dot.vy]
			else if (dot.x < 0 || dot.x > this.canvas.width) [dot.vx, dot.vy] = [-dot.vx, dot.vy]

			dot.x += dot.vx
			dot.y += dot.vy
		}
	}
}

type CanvasInitType = {
	canvas: HTMLCanvasElement | null
}

const canvasInit = ({
	canvas,
}: CanvasInitType) => {
	if (!canvas) return

	canvas.style.display = 'block'
	canvas.width = canvas.clientWidth
	canvas.height = canvas.clientHeight

	const ctxCanvas = canvas?.getContext('2d')
	const color = '#72cc96'

	if (!ctxCanvas) return

	ctxCanvas.fillStyle = color
	ctxCanvas.strokeStyle = color
	ctxCanvas.lineWidth = 0.1

	const dots: DotsType = {
		nb: 500,
		array: [],
	}

	const createDots = () => {
		let dot = undefined

		ctxCanvas.clearRect(0, 0, canvas.width, canvas.height)

		for (let i = 0; i < dots.nb; i++) {
			dots.array.push(new Dot(canvas, ctxCanvas, dots))
			dot = dots.array[i]
			dot && dot.create()
		}

		dot && dot.animate()
	}

	return setInterval(createDots, 1000 / 30)
}

export const CanvasAnimation = ({ className }: { className?: string } = {}) => {
	const canvasRef = useRef(null)

	useEffect(() => {
		const canvas = canvasRef.current
		const animationTimerId = canvasInit({ canvas })

		return () => clearInterval(animationTimerId)
	}, [])

	return (
		<canvas
			className={className}
			ref={canvasRef}
			width="auto"
			height="auto"
		></canvas>
	)
}
