import {
	Outlet,
	useLoaderData,
	useMatches,
} from 'react-router'
import { Footer } from '#app/components/footer.tsx'
import { Header } from '#app/components/header.tsx'
import { type loader } from '#app/root.tsx'

export function MainOutlet() {
	const data = useLoaderData<typeof loader>()

	return (
		<div className="grid min-h-screen grid-cols-1 grid-rows-1 md:grid-cols-1 md:grid-rows-1">
			<div className=''>
				<div className="flex flex-col min-h-screen">
					<Header />
					<div className='container py-6 flex flex-1 flex-col place-content-center'>
						<Outlet />
					</div>
					<Footer theme={data.requestInfo.userPrefs.theme}/>
				</div>
			</div>
		</div>
	)
}
