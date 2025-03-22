import Link from "next/link";
import {Button} from "@/components/ui/button";

export default function NavBar() {
  return (
    <nav className="flex justify-between p-4 bg-black">
      <Link className="ml-2 navbar-brand text-primary tracking-tight text-3xl font-bold" href="/frontend/public">
        Food Finds
      </Link>

      <div className="btn-group space-x-3">
        <Button variant="secondary">Sign Up</Button>
        <Button>Login</Button>
      </div>
    </nav>
  );
}