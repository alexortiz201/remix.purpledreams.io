export default function ExperimentsRoute() {
	return (
		<main className="font-poppins grid place-items-center px-4 py-16 font-light xl:grid-cols-1 xl:gap-24">
			<div className="items-left xl:items-left flex max-w-md flex-col xl:order-2">
				<h2 className="mt-8 animate-slide-top text-3xl text-foreground [animation-delay:0.3s] [animation-fill-mode:backwards] md:text-3xl xl:mt-4 xl:animate-slide-left xl:text-3xl xl:[animation-delay:0.8s] xl:[animation-fill-mode:backwards] underline decoration-[var(--pink)] decoration-[2px]">
					Experiments
				</h2>
        <p
					data-paragraph
					className="mt-6 animate-slide-top text-xl/7 text-muted-foreground [animation-delay:0.8s] [animation-fill-mode:backwards] xl:mt-8 xl:animate-slide-left xl:text-xl/6 xl:leading-10 xl:[animation-delay:1s] xl:[animation-fill-mode:backwards]"
				>
					All of these a projects that are WIP or a way for me to test some cool stuff out!
				</p>
				<ul className="mt-12 grid gap-x-8 gap-y-6 auto-cols-[minmax(0,2fr)] grid-flow-row md:grid-flow-col">
					{/* {posts.map(post => (
						<li
							key={post.slug}
							className="relative p-2 border-dashed border-[1px] border-[var(--purple)] transition duration-250 ease-in-out hover:border-solid  hover:scale-105"
						>
							<Link
								to={`/experiments/${post.slug}`}
								aria-label="Read more">
									<p className="text-lg font-light underline decoration-[var(--pink)] decoration-[2px] mb-1">{post.entry.title}</p>
									<p className="text-sm text-slate-500 italic">
										{format(post.entry.publishedOn, 'd MMMM yyyy')}
									</p>
							</Link>
						</li>
					))} */}
				</ul>
			</div>
		</main>
	)
}
