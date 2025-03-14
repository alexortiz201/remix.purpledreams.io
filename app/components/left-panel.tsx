import { CanvasAnimation } from './canvas'
import { Icon } from './ui/icon'

const PURPLEDREAMS_LINK = '/'
const Content = () => {
	return (
		<div className="grid place-items-center px-4 py-16 font-light xl:grid-cols-1 xl:gap-24">
			<div className="flex max-w-md flex-col items-center text-center xl:order-2 xl:items-center">
				<a href={PURPLEDREAMS_LINK} className="a__logo-link w-[60px]">
					<img src="/img/logo04.png" />
				</a>
				<h1
					data-heading
					className="mt-2 text-4xl text-foreground md:text-5xl xl:mt-2 xl:text-6xl"
				>
					<a href={PURPLEDREAMS_LINK} className="border-animation">
						<span className="border-animation font-extralight">purple</span>
						<span className="border-animation font-medium">dreams</span>
					</a>
				</h1>
				<div className="mt-6 flex justify-between text-xl/7 text-muted-foreground xl:mt-8 xl:text-xl/6 xl:leading-10">
					<ul className="flex list-none gap-2">
						<li className="flex">
							<a
								className="social-btn"
								href="https://linkedin.com/in/alexortiz201"
								target="_blank"
								rel="noopener noreferrer"
							>
								<Icon className="size-[1.5em]" name="linkedin-logo">
									<span className="sr-only">LinkedIn</span>
								</Icon>
							</a>
						</li>
						<li className="flex">
							<a
								className="social-btn"
								href="https://github.com/alexortiz201"
								target="_blank"
								rel="noopener noreferrer"
							>
								<Icon className="size-[1.5em]" name="github-logo">
									<span className="sr-only">Github</span>
								</Icon>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	)
}

export const LeftPanel = ({ className }: { className?: string } = {}) => {
	return (
		<div className={`${className}`}>
			<div className="absolute flex w-full flex-1 flex-col">
				<Content />
			</div>
			<div className="left-panel h-full min-h-screen"></div>
			<CanvasAnimation className="absolute -z-10 size-full min-h-screen" />
		</div>
	)
}
