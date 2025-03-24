import {cn} from "@/lib/utils";

export default function H2(props: React.HTMLProps<HTMLHeadingElement>) {
  return (
    <h2 {...props} className={cn("text-3xl md:text-4xl font-bold mb-2", props.className)} />
  );
}