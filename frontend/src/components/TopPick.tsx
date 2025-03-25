import Image from "next/image";

interface TopPickProps {
  imageData: { path: string; alt: string };
  vendorName: string;
  foodName: string;
  foodPrice: string;
  rating: string;
}

export default function TopPick({
  imageData,
  vendorName,
  foodName,
  foodPrice,
  rating,
}: TopPickProps) {
  return (
    <div className="bg-muted-foreground relative aspect-[3/3.5] rounded-xl">
      <span className="pick-card-image-group">
        <div className="relative aspect-4/3 rounded-lg">
          <Image
            fill
            src={imageData.path}
            alt={imageData.alt}
            className="object-cover p-2 rounded-2xl"
          />
          <div className="relative flex items-center top-1/10 left-4 bg-primary text-sm text-white rounded-full w-fit pb-0.5 px-2">
            <span className="truncate">{rating}</span>
          </div>
        </div>
      </span>

      <div className="absolute pl-2 max-w-[90%]">
        <div className="font-bold flex w-fit max-w-[100%]">
          <span className="truncate">{vendorName}</span>
        </div>
        <div className="font-thin text-sm flex w-fit max-w-[100%]">
          <span className="truncate">{foodName}</span>
        </div>
        <div className="font-semibold pt-2 flex w-fit max-w-[100%]">
          <span className="truncate">{foodPrice}</span>
        </div>
      </div>
    </div>
  );
}
