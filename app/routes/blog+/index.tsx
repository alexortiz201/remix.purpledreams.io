import { invariantResponse } from '@epic-web/invariant';
import { Link, type LoaderFunctionArgs, useLoaderData } from 'react-router'
import { GeneralErrorBoundary } from '#app/components/error-boundary.tsx'
// import { json } from 'node';
// import { Icon } from '#app/components/ui/icon.tsx'
import { type Route } from './+types/index.ts'

export const meta: Route.MetaFunction = () => [{ title: 'Purple Dreams | Blog' }]

export async function loader({ params }: LoaderFunctionArgs) {
  // pull in posts, parse mdx
  const posts = [] as Array<any>

  // redirect to post if found
  if (params?.id) {}

  invariantResponse(posts.length, 'No Posts Found', { status: 404 })

  return { posts }
}

export default function BlogRoute() {
  const { posts } = useLoaderData<typeof loader>()
  return (
    <main>
      <h1>Posts</h1>
       <ul>
        {
          posts.map(post => (
            <li key={post.slug}>
              <Link to={post.slug} className="text-blue-600 underline">post.title</Link>
            </li>)
          )
        }
        </ul>
    </main>
  );
}

export function ErrorBoundary() {
	return <GeneralErrorBoundary />
}