package vsu.csf.rentyserver.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vsu.csf.rentyserver.exception.NoSuchElementException;
import vsu.csf.rentyserver.model.dto.rent.request.CreateRentRequest;
import vsu.csf.rentyserver.model.dto.rent.request.ProlongRentRequest;
import vsu.csf.rentyserver.model.dto.rent.response.RentResponse;
import vsu.csf.rentyserver.model.entity.AppUser;
import vsu.csf.rentyserver.model.entity.Product;
import vsu.csf.rentyserver.model.entity.RentEvent;
import vsu.csf.rentyserver.model.entity.Size;
import vsu.csf.rentyserver.model.entity.enumeration.RentStatus;
import vsu.csf.rentyserver.model.entity.id.SizeId;
import vsu.csf.rentyserver.model.mapping.RentMapper;
import vsu.csf.rentyserver.repository.AppUsersRepository;
import vsu.csf.rentyserver.repository.ProductsRepository;
import vsu.csf.rentyserver.repository.RentEventRepository;
import vsu.csf.rentyserver.repository.SizesRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Service
@Slf4j
@RequiredArgsConstructor
@Transactional
public class RentService {

    private final RentEventRepository eventRepository;
    private final AppUsersRepository usersRepository;
    private final ProductsRepository productsRepository;
    private final SizesRepository sizesRepository;

    private final RentMapper rentMapper;

    @Transactional(readOnly = true)
    public List<RentResponse> getAll(Long userId) {
        log.info("List all rents for user {} called", userId);

        return rentMapper.map(eventRepository.findRentEventsByUser_userIdEquals(userId));
    }

    @Transactional(readOnly = true)
    public List<RentResponse> getOngoing(Long userId) {
        log.info("List all ongoing for user {} called", userId);

        var statuses = Set.of(RentStatus.ONGOING, RentStatus.EXPIRED);
        return rentMapper.map(eventRepository.findRentEventsByUser_userIdEqualsAndStatusIsIn(userId, statuses));
    }

    @Transactional(readOnly = true)
    public RentResponse getOne(Long rentId) {
        log.info("Get rent {} called", rentId);

        var rent = eventRepository.findById(rentId)
                .orElseThrow(() -> new NoSuchElementException("rent", RentEvent.class, rentId));

        return rentMapper.map(rent);
    }

    @Transactional(readOnly = true)
    public boolean owns(Long userId, Long rentId) {
        return eventRepository.findById(rentId)
                .orElseThrow(() -> new NoSuchElementException("rent", RentEvent.class, rentId))
                .getUser().getUserId().equals(userId);
    }

    public List<RentResponse> create(Long userId, List<CreateRentRequest> requests) {

        List<RentEvent> events = new ArrayList<>();

        var user = usersRepository.findById(userId)
                .orElseThrow(() -> new NoSuchElementException("user", AppUser.class, userId));

        for (CreateRentRequest request: requests) {
            log.info("Create rent {} by user {} called", request, userId);

            var product = productsRepository.findById(request.productId())
                    .orElseThrow(() -> new NoSuchElementException("product", Product.class, request.productId()));

            var sizeId = new SizeId()
                    .setName(request.sizeName())
                    .setProduct(product);

            var size = sizesRepository.findById(sizeId)
                    .orElseThrow(() -> new NoSuchElementException("size", Size.class, sizeId));

            var rentEvent = new RentEvent()
                    .setUser(user)
                    .setStartTime(request.startTime())
                    .setEndTime(request.endTime())
                    .setProduct(product)
                    .setSize(size)
                    .setCount(request.count())
                    .setPrice(product.getPrice());

            var saved = eventRepository.save(rentEvent);

            events.add(saved);

        }

        return rentMapper.map(events);

    }

    public RentResponse prolong(Long rentId, ProlongRentRequest request) {

        var rent = eventRepository.findById(rentId)
                .orElseThrow(() -> new NoSuchElementException("rent", RentEvent.class, rentId));

        rent.setEndTime(request.endTime());

        var changed = eventRepository.save(rent);

        return rentMapper.map(changed);

    }

}
