// import { Img } from 'openimg/react'

const HOME_LINK = '/'
export const LogoWithText = ({ logoLink = HOME_LINK } = {}) => (
  <>
    <a href={logoLink}>
      Salon Expo Studio
    </a>
    <h1
      data-heading
      className="mt-2 text-4xl text-foreground md:text-5xl xl:mt-2 xl:text-6xl"
    >
      <a href={HOME_LINK} className="underline decoration-[var(--green)] decoration-[3px]">
        <span className="font-extralight">salon</span>
        <span className="font-medium">expo</span>
      </a>
    </h1>
  </>
)