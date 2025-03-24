import {cn} from "@/lib/utils";

export default function H3(props: React.HTMLProps<HTMLHeadingElement>) {
  return (
    <h3 {...props} className={cn("text-2xl font-bold tracking-tight", props.className)}/>
  );
}
