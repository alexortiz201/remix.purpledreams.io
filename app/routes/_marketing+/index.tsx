// import { cn } from '#app/utils/misc.tsx'
import { type Route } from './+types/index.ts'

export const meta: Route.MetaFunction = () => [{ title: 'Purple Dreams' }]

// Tailwind Grid cell classes lookup
// const columnClasses: Record<(typeof logos)[number]['column'], string> = {
// 	1: 'xl:col-start-1',
// 	2: 'xl:col-start-2',
// 	3: 'xl:col-start-3',
// 	4: 'xl:col-start-4',
// 	5: 'xl:col-start-5',
// }
// const rowClasses: Record<(typeof logos)[number]['row'], string> = {
// 	1: 'xl:row-start-1',
// 	2: 'xl:row-start-2',
// 	3: 'xl:row-start-3',
// 	4: 'xl:row-start-4',
// 	5: 'xl:row-start-5',
// 	6: 'xl:row-start-6',
// }
const love = `love`
export default function Index() {
	return (
		<main className="font-poppins grid place-items-center px-4 py-16 xl:grid-cols-1 xl:gap-24 font-light">
			<div className="flex max-w-md flex-col items-left xl:order-2 xl:items-left">
				<h2 className='mt-8 animate-slide-top text-3xl text-foreground [animation-delay:0.3s] [animation-fill-mode:backwards] md:text-3xl xl:mt-4 xl:animate-slide-left xl:text-3xl xl:[animation-delay:0.8s] xl:[animation-fill-mode:backwards]'>
					About
				</h2>
				<p data-paragraph className="mt-6 animate-slide-top text-xl/7 text-muted-foreground [animation-delay:0.8s] [animation-fill-mode:backwards] xl:mt-8 xl:animate-slide-left xl:text-xl/6 xl:leading-10 xl:[animation-delay:1s] xl:[animation-fill-mode:backwards]">
					<span className='block'>
						Front end focus full stack engineer.
					</span>
					I <span className="color-pink">{ love }</span> building wonderful web experiences,
					from the pixel perfect layouts on the frontend to reliable, scalable,
					and easy to use API’s on the backend.
				</p>
			</div>
		</main>
	)
}
