import { ColoredDotsAnimation } from '#app/components/canvas-animations/canvas-colored-dots.tsx'
import { LogoWithSocial } from './logo-with-social'

export const LeftPanel = () => {
	return (
		<div className="dark relative col-[1] row-[1] flex min-h-screen flex-col place-content-center">
			<div className="absolute flex w-full flex-1 flex-col z-10">
				<LogoWithSocial className='px-4 py-16' />
			</div>

			<ColoredDotsAnimation className="absolute size-full min-h-screen -z-40" />
			<div className='bg-[var(--color-gray-333)] -z-50'>
				<div className="bg-[url(/img/unsplash-image-1.jpg)] bg-cover opacity-[0.7] h-full min-h-screen"></div>
			</div>
		</div>
	)
}
