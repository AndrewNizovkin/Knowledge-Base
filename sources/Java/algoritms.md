# Алгоритмы

### Шейкерная сортировка

Это разновидность пузырьковой сортировки. Отличается тем, что просмотры элементов выполняются один за другим в противоположных направлениях, при этом большие элементы стремятся к концу массива, а маленькие - к началу.

```java
/**
     * Shaker Sort
     * @param arr
     */
    public static void shakerSort(int[] arr){
        int n = arr.length;
        for(int i = 0; i < n / 2; i++){
            for(int j = i; j < n - 1 - i; j++){
                if(arr[j] > arr[j+1]){
                    int temp = arr[j];
                    arr[j] = arr[j+1];
                    arr[j+1] = temp;
                }
            }

            for(int j = n - 1 - i; j > i; j--){
                if(arr[j] < arr[j-1]){
                    int temp = arr[j];
                    arr[j] = arr[j-1];
                    arr[j-1] = temp;
                }
            }
        }
    }
```

### Cортировка слиянием.

```java
/**
     * Merge Sort
     * @param arr
     */
    public static void mergeSort(int[] arr){
        mergeSort(arr, 0, arr.length - 1);
    }

    public static int[] buff = new int[100001];

    public static void mergeSort(int[] arr, int left, int right){ // O(n * log n)
        if(left == right){
            return ;
        }
        int mid = (left + right) / 2;
        mergeSort(arr, left, mid);
        mergeSort(arr, mid + 1, right);

        int i = left, j = mid+1, k = left;
        while(i <= mid && j <= right){
            if(arr[i] < arr[j]){
                buff[k++] = arr[i++];
            }else{
                buff[k++] = arr[j++];
            }
        }

        while(i <= mid){
            buff[k++] = arr[i++];
        }

        while(j <= right){
            buff[k++] = arr[j++];
        }

        for(int q = left; q<=right; q++){
            arr[q] = buff[q];
        }
    }
```

---

### Бинарный поиск

```java
/**
     * BinarySearch
     * @param array
     * @param valume
     * @return
     */
    public static int BinarySearch(int[] array, int valume){ // O(log N)
        int left = 0, right = array.length - 1;
        while(right - left > 1){
            int mid = (left + right) / 2;
            if(array[mid] >= valume){
                right = mid;
            }else{
                left = mid;
            }
        }
        if(array[left] == valume)
            return left;
        if(array[right] == valume)
            return right;
        return -1;
    }
```

---

### Сортировка кучей

```java
/**
     * Sorts by a heap style
     * @param array integer array
     */
    public static void sort(int[] array) {
        for (int i = array.length / 2 - 1; i >=0; i--) {
            heapify(array, array.length, i);
        }

        for (int i = array.length - 1; i >=0; i--) {
            int temp = array[0];
            array[0] = array[i];
            array[i] = temp;

            heapify(array, i, 0);
        }
    }

    /**
     * builds the heap
     * @param array integer array
     * @param heapSize heap size
     * @param rootIndex root index (parent node)
     */
    private static void heapify(int[] array, int heapSize, int rootIndex) {
        int largest = rootIndex;
        int leftChild = 2 * rootIndex + 1;
        int rightChild = 2 * rootIndex + 2;

        if (leftChild < heapSize && array[leftChild] > array[largest]) {
            largest = leftChild;
        }

        if (rightChild < heapSize && array[rightChild] > array[largest]) {
            largest = rightChild;
        }

        if (largest != rootIndex) {
            int temp = array[rootIndex];
            array[rootIndex] = array[largest];
            array[largest] = temp;

            heapify(array, heapSize, largest);
        }
    }
```