import mmcv
import numpy as np
import torch
import cv2
from app import model, mps_device, colormap, labelmap, hexmap

def processInput(bytes: bytes) -> torch.Tensor:
	img = mmcv.imfrombytes(bytes, flag='color', channel_order='rgb')
	resized_img = mmcv.image.imresize(img, size=(768,768))
	normalized_img = mmcv.imnormalize(resized_img,
						mean=np.array([123.675, 116.28, 103.53]),
						std=np.array([58.395, 57.12, 57.375]),
						to_rgb=True
						)
	tensor_img = torch.Tensor(normalized_img)
	tensor_img = tensor_img.unsqueeze(0).permute(0, 3, 1, 2).to(mps_device)
	return tensor_img, resized_img

def processOutput(tensors) -> torch.Tensor:
	argmax_results = tensors[0].permute(1,2,0).argmax(dim=2)
	return argmax_results

def segmentation(tensor) -> torch.Tensor:
	with torch.no_grad():
		results = model.forward(tensor, mode="tensor")
	return results

def segment_pipeline(bytes: bytes) -> torch.Tensor:
	tensor_img, original_img = processInput(bytes)
	results = segmentation(tensor_img)
	return processOutput(results), original_img

# Retrieve ids, labels, hexcode colors from an Image Tensor (so that we dont have to pass the entire thing)
def get_label_map(image: np.ndarray) -> list[dict]:
	labels = []
	unique_ids = np.unique(image)
	for id in unique_ids:
		if id != 0 and id != 103:
			labels.append({
				"label": labelmap[str(id)],
				"color": hexmap[str(id)]
			}) 
	return labels

# Returns the colorized version of a pixel
def colorize_pixel(id: int):
	dic = colormap[str(id)]
	return np.array([dic["r"], dic["g"], dic["b"]])

# Process image to more contrasting colors and proper sizing
def process_image_for_flutter(original_image: np.ndarray, image: np.ndarray) -> np.ndarray:
	# Get segments
	colorized_segments = np.array([np.array([colorize_pixel(j) for j in i]) for i in image], np.uint8)
	# Merge
	merged = cv2.addWeighted(original_image.astype(np.uint8), 0.5, colorized_segments, 1, 0)
	return mmcv.imresize(merged, size=(480,640))


