import { makePage } from '@keystatic/remix/ui'
import config from '#/keystatic.config'
import { requireUserWithRole } from '#app/utils/permissions.server.ts'
import { type Route } from './+types/$'

export async function loader({ request }: Route.LoaderArgs) {
  await requireUserWithRole(request, 'admin')
  return Response.json({ ok: true });
}

export default makePage(config)