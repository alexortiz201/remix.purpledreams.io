import {
	Outlet,
	useLoaderData,
	useMatches,
} from 'react-router'
import { Footer } from '#app/components/footer.tsx'
import { Header } from '#app/components/header.tsx'
import { LeftPanel } from '#app/components/left-panel.tsx'
import { type loader } from '#app/root.tsx'

function Splash() {
	const data = useLoaderData<typeof loader>()

	return (
		<div className="grid min-h-screen grid-cols-1 grid-rows-2 md:grid-cols-2 md:grid-rows-1">
			<div className="col-[1] row-[1]">
				<LeftPanel />
			</div>
			<div className='col-[1] row-[2] md:col-[2] md:row-[1]'>
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

function Main() {
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

export function MainOutlet() {
  const matches = useMatches()
  const isOnSplashPage = matches.find((m) => m.id === 'routes/_index')

  return isOnSplashPage ? <Splash /> : <Main />
}