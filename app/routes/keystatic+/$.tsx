import { makePage } from '@keystatic/remix/ui'
import { redirect } from 'react-router'
import config from '#/keystatic.config'
import { tryOp } from '#app/utils/misc.tsx'
import { requireUserWithRole } from '#app/utils/permissions.server.ts'
import { type Route } from './+types/$'

export async function loader({ request }: Route.LoaderArgs) {
  const [, error] = await tryOp(requireUserWithRole(request, 'admin'))

  if (error) return redirect('/blog')

  return Response.json({ ok: true });
}

export default makePage(config)