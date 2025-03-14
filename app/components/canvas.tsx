import { useEffect, useRef } from 'react'

type DotsType = {
	nb: number
	distance: number
	d_radius: number
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

			if (dot.y < 0 || dot.y > this.canvas.height) {
				;[dot.vx, dot.vy] = [dot.vx, -dot.vy]
			} else if (dot.x < 0 || dot.x > this.canvas.width) {
				;[dot.vx, dot.vy] = [-dot.vx, dot.vy]
			}
			dot.x += dot.vx
			dot.y += dot.vy
		}
	}
}

// canvasInit(document.querySelector('canvas'))
const canvasInit = (canvas: HTMLCanvasElement | null) => {
	const ctxCanvas = canvas?.getContext('2d')

	if (!canvas || !ctxCanvas) return

	canvas.style.display = 'block'

	const color = '#72cc96'
	ctxCanvas.fillStyle = color
	ctxCanvas.strokeStyle = color
	ctxCanvas.lineWidth = 0.1
	const mousePosition = {
		x: (30 * canvas.width) / 100,
		y: (30 * canvas.height) / 100,
	}
	const dots: DotsType = {
		nb: 500,
		distance: 80,
		d_radius: 150,
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
		const animationTimerId = canvasInit(canvas)

		return () => {
			clearInterval(animationTimerId)
		}
	}, [])

	return (
		<canvas
			className={className}
			ref={canvasRef}
			width="960"
			height="633"
		></canvas>
	)
}

export const dotInit = () => {}
