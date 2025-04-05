export default function AboutRoute() {
	return (
		<main className="font-poppins grid place-items-center px-4 py-16 font-light xl:grid-cols-1 xl:gap-24">
			<div className="items-left xl:items-left flex max-w-md flex-col xl:order-2">
				<h2 className="mt-8 animate-slide-top text-3xl text-foreground [animation-delay:0.3s] [animation-fill-mode:backwards] md:text-3xl xl:mt-4 xl:animate-slide-left xl:text-3xl xl:[animation-delay:0.8s] xl:[animation-fill-mode:backwards]">
					About
				</h2>
				<p
					data-paragraph
					className="mt-6 animate-slide-top text-xl/7 text-muted-foreground [animation-delay:0.8s] [animation-fill-mode:backwards] xl:mt-8 xl:animate-slide-left xl:text-xl/6 xl:leading-10 xl:[animation-delay:1s] xl:[animation-fill-mode:backwards]"
				>
					<span className="block">Front end focus full stack engineer.</span>
					I <span className="color-pink">love</span> building wonderful web
					experiences, from the pixel perfect layouts on the frontend to
					reliable, scalable, and easy to use API’s on the backend.
				</p>
			</div>
		</main>
	)
}
