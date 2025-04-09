const PURPLEDREAMS_LINK = '/'
export const LogoWithText = ({ logoLink = PURPLEDREAMS_LINK } = {}) => (
  <>
    <a href={logoLink} className="w-[60px]">
      <img className='grayscale-[25%]' src="/img/logo04.png" />
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