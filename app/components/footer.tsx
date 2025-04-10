import { SmallNavLogo } from '#app/components/small-home-nav-logo'
import { ThemeSwitch } from '#app/routes/resources+/theme-switch.tsx'
import  { type Theme } from '#app/utils/theme.server.ts'

export function Footer({ theme }: { theme: Theme | null }) {
  return (
    <footer className="container py-6 flex flex-wrap items-center justify-between gap-4 sm:flex-nowrap md:gap-8">
      <SmallNavLogo />
      <ThemeSwitch userPreference={theme} />
    </footer>
  )
}