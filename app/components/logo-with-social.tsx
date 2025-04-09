import { cn } from '#app/utils/misc.tsx'
import { LogoWithText } from './logo-with-text'
import { SocialLinkList } from './social-icon-link-list'

export const LogoWithSocial = ({ className }: { className?: string }) => {
  return (
    <div className={cn("grid place-items-center font-light xl:grid-cols-1 xl:gap-24", className)}>
      <div className="flex max-w-md flex-col items-center text-center xl:order-2 xl:items-center">
        <LogoWithText />
        <div className="mt-6 flex justify-between text-xl/7 text-muted-foreground xl:mt-8 xl:text-xl/6 xl:leading-10">
          <SocialLinkList />
        </div>
      </div>
    </div>
  )
}