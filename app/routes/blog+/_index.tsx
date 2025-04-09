import { format } from 'date-fns'
import { Link, useLoaderData } from 'react-router'
import { LogoWithSocial } from '#app/components/logo-with-social.tsx'
import { reader } from '#utils/keystatic-reader.server'
import { type Route } from './+types/_index'

export const meta: Route.MetaFunction = () => [{ title: 'Purple Dreams | Blog' }]

export async function loader() { // { request }: Route.LoaderArgs
	const posts = await reader.collections.posts.all()

	const sortedPosts = posts.sort((a, b) => {
		return a.entry.publishedOn.localeCompare(b.entry.publishedOn)
	})

	return { posts: sortedPosts }
}

export default function PostsList() {
	const { posts } = useLoaderData<typeof loader>()
	return (
		<div className="container py-16 text-center">
			<LogoWithSocial />
			<p className="text-3xl my-4">🙈🙊🙉</p>
			<p>
				Blog about things I've found interesting or worth repeating.
			</p>
			{posts.length && (
				<ul className="mt-12 grid gap-x-8 gap-y-6 auto-cols-[minmax(0,2fr)] grid-flow-col">
					{posts.map(post => (
						<li
							key={post.slug}
							className="relative rounded-md bg-gradient-to-b from-white via-white via-70% to-black/5 p-6 shadow ring-1 ring-black/5 transition duration-75 hover:to-black/[0.03] hover:shadow-sm hover:ring-black/20"
						>
							<Link
								to={`/blog/${post.slug}`}
								className="absolute inset-0"
								aria-label="Read more"
							/>
							<p className="font-medium text-slate-900">{post.entry.title}</p>
							<p className="mt-1 text-sm text-slate-500">
								{format(post.entry.publishedOn, 'd MMMM yyyy')}
							</p>
						</li>
					))}
				</ul>
			)}
		</div>
	)
}