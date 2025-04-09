import { Link } from 'react-router'
import { Icon } from './ui/icon'

export const SocialLinkList = () => (
	<>
		<ul className="flex list-none gap-2">
			<li className="flex">
				<a
					className="social-btn"
					href="https://linkedin.com/in/alexortiz201"
					target="_blank"
					rel="noopener noreferrer"
				>
					<Icon className="size-[1.5em]" name="linkedin-logo">
						<span className="sr-only">LinkedIn</span>
					</Icon>
				</a>
			</li>
			<li className="flex">
				<a
					className="social-btn"
					href="https://github.com/alexortiz201"
					target="_blank"
					rel="noopener noreferrer"
				>
					<Icon className="size-[1.5em]" name="github-logo">
						<span className="sr-only">Github</span>
					</Icon>
				</a>
			</li>
			<li className="flex">
				<Link to="/blog">
					<Icon className="size-[1.5em] social-btn" name="chat-bubble">
						<span className="sr-only">Blog</span>
					</Icon>
				</Link>
			</li>
		</ul>
	</>
)