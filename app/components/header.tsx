import { Link, useMatches } from 'react-router'
import { SearchBar } from '#app/components/search-bar.tsx'
import { SmallNavLogo } from '#app/components/small-home-nav-logo'
import { Button } from '#app/components/ui/button.tsx'
import { UserDropdown } from '#app/components/user-dropdown.tsx'
import { useOptionalUser } from '#app/utils/user.ts'

const LoginAndSearch = () => {
  const matches = useMatches()
  const isOnSearchPage = matches.find((m) => m.id === 'routes/users+/index')
  const user = useOptionalUser()
  const searchBar = isOnSearchPage ? null : <SearchBar status="idle" />

  return (
    <>
      <div className="ml-auto hidden max-w-sm flex-1 sm:block">
        {searchBar}
      </div>
      <div className="flex items-center gap-10">
        {user ? (
          <UserDropdown />
        ) : (
          <Button asChild variant="default" size="lg">
            <Link to="/login">Log In</Link>
          </Button>
        )}
      </div>
      <div className="block w-full sm:hidden">{searchBar}</div>
    </>
  )
}

export function Header() {
  return (
    <header className='container py-6'>
      <nav className="flex flex-wrap items-center justify-between gap-4 sm:flex-nowrap md:gap-8">
        <SmallNavLogo />
        { ENV.MOCKS === 'true' && <LoginAndSearch /> }
      </nav>
    </header>
  )
}