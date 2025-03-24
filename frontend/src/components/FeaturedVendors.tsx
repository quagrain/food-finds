import Image from "next/image";
import { cn } from "@/lib/utils";

interface FeaturedVendorsProps {
  chip_className?: string;
  img_className?: string;
  aspect_ratio: "stack" | "full";
  image_path: string;
  image_alt: string;
  vendor: string;
}

export default function FeaturedVendor({
  chip_className,
  img_className,
  aspect_ratio,
  image_path,
  image_alt,
  vendor,
}: FeaturedVendorsProps) {
  return (
    <div
      className={
        aspect_ratio === "stack"
          ? "relative aspect-[3/2.2] rounded-lg overflow-hidden"
          : "relative aspect-[3/4.5] rounded-lg overflow-hidden"
      }
    >
      <Image
        fill
        src={image_path}
        alt={image_alt}
        className={cn("object-cover", img_className)}
      />
      <div className="relative top-3 left-4 overflow-hidden">
        <div
          className={cn(
            "bg-primary rounded-full flex items-center pb-0.5 px-2 text-sm text-white w-fit max-w-[50%]",
            chip_className,
          )}
        >
          <span className="truncate">{vendor}</span>
        </div>
      </div>
    </div>
  );
}
