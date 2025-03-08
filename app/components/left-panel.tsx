import { CanvasAnimation } from "./canvas"

const Content = () => {
  return (
    <div className="grid place-items-center px-4 py-16 xl:grid-cols-1 xl:gap-24 font-light">
      <div className="flex max-w-md flex-col items-center text-center xl:order-2 xl:items-center">
        <a
          href="https://purpledreams.io"
          className="a__logo-link w-[150px]"
        >
          <img src="/img/logo04.png" />
        </a>
        <h1
          data-heading
          className="mt-8 text-4xl text-foreground md:text-5xl xl:mt-4 xl:text-6xl"
        >
          <a href="https://www.purpledreams.io" className="border-animation">
            <span className="border-animation">Purple Dreams</span>
          </a>
        </h1>
        <p
          data-paragraph
          className="mt-6 text-xl/7 text-muted-foreground xl:mt-8 xl:text-xl/6 xl:leading-10"
        >
          Check the{' '}
          <a
            className="underline hover:no-underline"
            href="https://github.com/epicweb-dev/epic-stack/blob/main/docs/getting-started.md"
          >
            Getting Started guide
          </a>{' '}
          file for how to get your project off the ground!
        </p>
      </div>
      {/* <ul className="mt-16 flex max-w-3xl flex-wrap justify-center gap-2 sm:gap-4 xl:mt-0 xl:grid xl:grid-flow-col xl:grid-cols-5 xl:grid-rows-6">
        <TooltipProvider>
          {logos.map((logo, i) => (
            <li
              key={logo.href}
              className={cn(
                columnClasses[logo.column],
                rowClasses[logo.row],
                'animate-roll-reveal [animation-fill-mode:backwards]',
              )}
              style={{ animationDelay: `${i * 0.07}s` }}
            >
              <Tooltip>
                <TooltipTrigger asChild>
                  <a
                    href={logo.href}
                    className="grid size-20 place-items-center rounded-2xl bg-violet-600/10 p-4 transition hover:-rotate-6 hover:bg-violet-600/15 dark:bg-violet-200 dark:hover:bg-violet-100 sm:size-24"
                  >
                    <img src={logo.src} alt="" />
                  </a>
                </TooltipTrigger>
                <TooltipContent>{logo.alt}</TooltipContent>
              </Tooltip>
            </li>
          ))}
        </TooltipProvider>
      </ul> */}
    </div>
  )
}

export const LeftPanel = ({ className } : { className?: string } = {}) => {
  return (
    <div className={`flex min-h-screen flex-col place-content-center col-[1] relative ${className}`}>
      <div className="flex flex-1 flex-col w-full absolute">
        <Content />
      </div>
      <div className="min-h-screen left-panel h-full"></div>
      <CanvasAnimation className="min-h-screen size-full absolute" />
    </div>
  )
}