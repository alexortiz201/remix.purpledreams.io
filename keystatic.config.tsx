import { config, fields, collection } from '@keystatic/core';
import { Link } from 'react-router'

const Mark = () => (
		<Link to='/' className="a__logo-link keystatic__logo-width">
			<img src="/img/logo04.png" />
			<span className="sr-only">Home</span>
		</Link>
	)

export default config({
  storage: {
    kind: 'local',
  },
  ui: {
		brand: {
			name: 'Purple Dreams',
			mark: () => <Mark />,
		},
	},
  collections: {
    posts: collection({
      label: 'Posts',
      slugField: 'title',
      path: 'app/assets/posts/*',
      format: { contentField: 'body' },
      schema: {
        title: fields.slug({ name: { label: 'Title' } }),
        publishedOn: fields.date({
					label: 'Published On',
					validation: { isRequired: true },
				}),
        body: fields.mdx({ label: 'Post Body' }),
      },
    }),
  },
});