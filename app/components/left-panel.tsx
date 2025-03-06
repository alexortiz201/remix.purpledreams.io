import { CanvasAnimation } from "./canvas"

const Content = () => {
  return (
    <div className="grid place-items-center px-4 py-16 xl:grid-cols-1 xl:gap-24">
      <div className="flex max-w-md flex-col items-center text-center xl:order-2 xl:items-center xl:text-left">
        <a
          href="https://purpledreams.io"
          className="animate-slide-top [animation-fill-mode:backwards] xl:animate-slide-left xl:[animation-delay:0.5s] xl:[animation-fill-mode:backwards] w-[200px]"
        >
          <img src="/img/logo.png" />
        </a>
        <h1
          data-heading
          className="mt-8 animate-slide-top text-4xl font-medium text-foreground [animation-delay:0.3s] [animation-fill-mode:backwards] md:text-5xl xl:mt-4 xl:animate-slide-left xl:text-6xl xl:[animation-delay:0.8s] xl:[animation-fill-mode:backwards]"
        >
          <a href="https://www.purpledreams.io">Purple Dreams</a>
        </h1>
        <p
          data-paragraph
          className="mt-6 animate-slide-top text-xl/7 text-muted-foreground [animation-delay:0.8s] [animation-fill-mode:backwards] xl:mt-8 xl:animate-slide-left xl:text-xl/6 xl:leading-10 xl:[animation-delay:1s] xl:[animation-fill-mode:backwards]"
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

export const LeftPanel = () => {
  return (
    <div className="flex min-h-screen flex-col justify-between col-[1] relative">
      <div className="flex flex-1 flex-col w-full absolute">
        <Content />
      </div>
      <div className="min-h-screen left-panel"></div>
      <CanvasAnimation className="min-h-screen w-full absolute" />
    </div>
  )
}