// import { Img } from 'openimg/react'

const PURPLEDREAMS_LINK = '/'
export const LogoWithText = ({ logoLink = PURPLEDREAMS_LINK } = {}) => (
  <>
    <a href={logoLink}>
      <img src="/img/logo04.png" alt={'Purple Dreams'} width={60} height={39} />
    </a>
    <h1
      data-heading
      className="mt-2 text-4xl text-foreground md:text-5xl xl:mt-2 xl:text-6xl"
    >
      <a href={PURPLEDREAMS_LINK} className="underline decoration-[var(--green)] decoration-[3px]">
        <span className="font-extralight">purple</span>
        <span className="font-medium">dreams</span>
      </a>
    </h1>
  </>
)