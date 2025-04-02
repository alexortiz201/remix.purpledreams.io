import { bundleMDX } from 'mdx-bundler'
import { getMDXComponent } from 'mdx-bundler/client'
import * as React from 'react'
import { useLoaderData } from 'react-router'

import { reader } from '#utils/keystatic-reader.server'
import { type Route } from './+types/$slug'

export async function loader({ params }: Route.LoaderArgs) {
	const { slug } = params

	if (!slug) throw new Response('Slug param missing', { status: 404 })

	const post = await reader.collections.posts.read(slug, {
		resolveLinkedFiles: true,
	})

	if (!post) throw new Response(`No post matching slug: ${slug}`, { status: 404 })

	const { code } = await bundleMDX({
		source: post.body,
	})

	return { post, code }
}

export default function Post() {
	const { post, code } = useLoaderData<typeof loader>()
	const Component = React.useMemo(() => getMDXComponent(code), [code])
	return (
		<div className="container py-16">
			<h1 className="text-3xl font-semibold">{post.title}</h1>
			<div className="prose prose-p:text-black mt-6">
				<Component />
			</div>
		</div>
	)
}